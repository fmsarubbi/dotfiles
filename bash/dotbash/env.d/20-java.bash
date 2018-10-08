if [ -f /etc/alternatives/javac -a -x /etc/alternatives/javac ]; then
  JAVA_HOME="$(dirname "$(dirname "$(readlink /etc/alternatives/javac)")")"
fi
