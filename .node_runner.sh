
node_scripts="/home/deyan/.cli-tools"

# each of those functions exposes a CLI tool written in node
g() {
    node "$node_scripts/gitr.js" $@
}
