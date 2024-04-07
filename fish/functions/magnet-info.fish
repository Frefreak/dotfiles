function magnet-info
  set -l hash  (echo "$argv[1]" | grep -oP "(?<=btih:).*?(?=&)")
  echo "Magnet hash: $hash"
  aria2c --bt-metadata-only=true --bt-save-metadata=true -q "$argv[1]"
  aria2c "$hash.torrent" -S
end
