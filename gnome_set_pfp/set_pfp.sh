#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"

IMAGE_FILES=("$SCRIPT_DIR"/*.png)

if [[ ${#IMAGE_FILES[@]} -eq 0 || ${IMAGE_FILES[0]} == "$SCRIPT_DIR/*.png" ]]; then
  echo "Error: No PNG files found in the script's directory ($SCRIPT_DIR)"
  exit 1
fi

for IMAGE in "${IMAGE_FILES[@]}"; do
  USERNAME="${IMAGE%.png}"
  USERNAME="${USERNAME##*/}"

  if id "$USERNAME" &>/dev/null; then
    DESTINATION="/var/lib/AccountsService/icons/$USERNAME"

    sudo rm -rf "$DESTINATION"
    
    sudo cp "$IMAGE" "$DESTINATION"

    sudo chown root:root "$DESTINATION"
    sudo chmod 0600 "$DESTINATION"
    sudo chmod 0444 "$DESTINATION"

    echo "Profile picture for $USERNAME updated successfully!"
  else
    echo "User $USERNAME does not exist. Skipping $IMAGE."
  fi
done

