#!/bin/bash
set -e

error() {
    echo "Ошибка: $1" >&2
    exit 1
}

get_api_key() {
    local env_file="$1/.env"
    [ -f "$env_file" ] && grep -E "^CURSOR_KEY=" "$env_file" | cut -d'=' -f2- | tr -d '"'"'" || echo ""
}

check_dependencies() {
    command -v curl &> /dev/null || error "curl не найден"
    command -v cwebp &> /dev/null || error "cwebp не найден"
    command -v jq &> /dev/null || error "jq не найден"
}

generate_image() {
    local prompt="$1" api_key="$2" size="${3:-1024x1024}" model="${4:-dall-e-3}"
    local quality_param=""
    [ "$model" = "dall-e-3" ] && quality_param='"quality": "standard",'
    
    local response
    response=$(curl -s -w "\n%{http_code}" \
        -X POST "https://api.openai.com/v1/images/generations" \
        -H "Authorization: Bearer $api_key" \
        -H "Content-Type: application/json" \
        -d "{\"model\":\"$model\",\"prompt\":\"$prompt\",\"size\":\"$size\",$quality_param\"n\":1}")
    
    local http_code="${response##*$'\n'}" body="${response%$'\n'*}"
    [ "$http_code" -ne 200 ] && error "Ошибка API: HTTP $http_code"
    
    local image_url
    image_url=$(echo "$body" | jq -r '.data[0].url // empty')
    [ -z "$image_url" ] && error "Не удалось получить URL"
    
    local temp_image
    temp_image=$(mktemp)
    curl -s -o "$temp_image" "$image_url" || error "Не удалось загрузить"
    echo "$temp_image"
}

generate_filename() {
    local safe_name
    safe_name=$(echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/_/g' | sed 's/__*/_/g' | sed 's/^_\|_$//g' | cut -c1-50)
    echo "${safe_name:-image_$(date +%s)}.webp"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
API_KEY=$(get_api_key "$PROJECT_ROOT")

PROMPT=""
SIZE="1024x1024"
MODEL="dall-e-3"
QUALITY=90

while [[ $# -gt 0 ]]; do
    case $1 in
        --size)
            [[ "$2" =~ ^(1024x1024|1792x1024|1024x1792)$ ]] || error "Неверный размер"
            SIZE="$2"; shift 2 ;;
        --model)
            [[ "$2" =~ ^(dall-e-3|dall-e-2)$ ]] || error "Неверная модель"
            MODEL="$2"; shift 2 ;;
        --quality)
            [[ "$2" =~ ^[0-9]+$ ]] && [ "$2" -ge 0 ] && [ "$2" -le 100 ] || error "Качество 0-100"
            QUALITY="$2"; shift 2 ;;
        -*)
            error "Неизвестная опция: $1" ;;
        *)
            [ -z "$PROMPT" ] && PROMPT="$1" || error "Неожиданный аргумент"
            shift ;;
    esac
done

[ -z "$PROMPT" ] && error "Промпт обязателен"
[ -z "$API_KEY" ] && error "CURSOR_KEY не найден в .env"

check_dependencies

OUTPUT_DIR="$PROJECT_ROOT/assets/ai_generated"
mkdir -p "$OUTPUT_DIR"

TEMP_IMAGE=$(generate_image "$PROMPT" "$API_KEY" "$SIZE" "$MODEL")
FILENAME=$(generate_filename "$PROMPT")
OUTPUT_PATH="$OUTPUT_DIR/$FILENAME"

cwebp -q "$QUALITY" "$TEMP_IMAGE" -o "$OUTPUT_PATH" -quiet || error "Ошибка конвертации"
rm -f "$TEMP_IMAGE"

echo "✅ ${OUTPUT_PATH#$PROJECT_ROOT/}"

