function urban-dictionary
  # curl http://api.urbandictionary.com/v0/define\?term\="$1" 2>/dev/null | \
  #   jq ".list | .[] | .definition" |& python -u -c \
  #   "print(__import__('sys').stdin.buffer.read().decode('unicode_escape'))"
end
