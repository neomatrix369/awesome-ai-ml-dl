export OLD_PATH=${PATH}

function switchTo11 {
    export JAVA_HOME=${JAVA_11_HOME}
    export JDK_HOME=${JAVA_HOME}
    echo "Switched to ${JAVA_HOME}" 1>&2
    export PATH="${JAVA_HOME}/bin:${OLD_PATH:-}"
    java -version
}

function switchToGraal {
    export JAVA_HOME=${GRAALVM_HOME}
    export JDK_HOME=${JAVA_HOME}
    echo "Switched to ${JAVA_HOME}" 1>&2
    export PATH="${JAVA_HOME}/bin:${OLD_PATH:-}"
    java -version
}

if [[ "${JDK_TO_USE:-}" = "GRAALVM" ]]; then
    switchToGraal
    JAVA_HOME=${GRAALVM_HOME}
else
    switchTo11
    JAVA_HOME=${JAVA_11_HOME}
fi

echo "PATH=${PATH}" 1>&2
echo "JAVA_HOME=${JAVA_HOME}" 1>&2