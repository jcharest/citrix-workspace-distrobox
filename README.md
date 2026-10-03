# Deps

Needs podman and distrobox.

# Run
podman build -t localhost/citrix-workspace:1.0 .

distrobox-assemble create --file citrix-workspace.ini

