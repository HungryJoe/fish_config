function tplant-since-commit --description "Generate PlantUML diagrams for TTAT service and component files changed since a given commit. Should be run from the root of the TTAT repo"
    echo Generating tplant diagrams...
    git diff --name-status $argv[1] frontend/src/ |
        awk '$1 ~ "[^D]" {print $2}' |
        rg --no-heading '\.(component|service|interceptor)\.ts$' |
        xargs -I{} tplant -i {} -o {}.puml
    fd \.puml\$ frontend/src/ | tee /dev/stderr | xargs -I{} mv {} diagrams/plant-uml/tplant/
    echo
    echo Moved generated diagrams into diagrams/plant-uml/tplant
end
