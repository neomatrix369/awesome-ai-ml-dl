~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Mode=traditional_jdk
JAVA_HOME=/usr/local/openjdk-8
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-b10)
OpenJDK 64-Bit Server VM (build 25.222-b10, mixed mode)
Grakn version: (see bottom of the startup text banner)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
====================================================================================================
      ________  _____     _______  __    __  __    __      _______  _______  _____     _______
     |   __   ||   _  \  |   _   ||  |  /  /|  \  |  |    |   _   ||   _   ||   _  \  |   ____|
     |  |  |__||  | |  | |  | |  ||  | /  / |   \ |  |    |  | |__||  | |  ||  | |  | |  |
     |  | ____ |  |_| /  |  |_|  ||  |/  /  |    \|  |    |  |     |  | |  ||  |_| /  |  |____
     |  ||_   ||   _  \  |   _   ||   _  \  |   _    |    |  |  __ |  | |  ||   _  \  |   ____|
     |  |__|  ||  | \  \ |  | |  ||  | \  \ |  | \   |    |  |_|  ||  |_|  ||  | \  \ |  |____
     |________||__|  \__\|__| |__||__|  \__\|__|  \__|    |_______||_______||__|  \__\|_______|

                                         THE KNOWLEDGE GRAPH
====================================================================================================
                                                                                      7
Starting Storage.......SUCCESS
Starting Grakn Core Server..............SUCCESS

real	0m51.683s
user	0m20.448s
sys	0m3.542s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...

~~~~ Current working directory: /home/grakn/shared
Already up-to-date.

~~~~ Updating maven dependencies via Bazel ~~~~
+ ./dependencies/maven/update.sh
(bazel takes a while to finish with it's part)

real    5m7.569s
user    0m57.088s
sys 0m17.933s
+ set +x

~~~~ Finished updating Maven dependencies via Bazel ~~~~
Extracting Bazel installation...
Starting local Bazel server and connecting to it...
Loading:
Loading: 0 packages loaded
Loading: 0 packages loaded
Loading: 0 packages loaded
DEBUG: Rule 'graknlabs_build_tools' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1572264161 +0300"
Loading: 0 packages loaded
DEBUG: Rule 'graknlabs_bazel_distribution' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1571396383 +0100"
Loading: 0 packages loaded
Loading: 0 packages loaded
DEBUG: Rule 'io_bazel_rules_python' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1545256788 -0500"
Loading: 0 packages loaded
Loading: 0 packages loaded
Loading: 0 packages loaded
Loading: 0 packages loaded
Loading: 0 packages loaded
Loading: 0 packages loaded
DEBUG: Rule 'com_github_grpc_grpc' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1550231355 +0300"
DEBUG: Rule 'stackb_rules_proto' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1561665037 -0600"
Loading: 0 packages loaded
DEBUG: Rule 'graknlabs_grakn_core' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1574675456 +0000"
DEBUG: Rule 'graknlabs_graql' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1574442342 +0000"
DEBUG: Rule 'rules_antlr' indicated that a canonical reproducible form can be obtained by modifying arguments commit = "397361a4d252a7186bc33add33144f4ede2a3899", shallow_since = "1559662328 +0200" and dropping ["tag"]
DEBUG: Rule 'com_github_google_bazel_common' indicated that a canonical reproducible form can be obtained by modifying arguments shallow_since = "1551104077 +0300"
Analyzing: target @graknlabs_build_tools//bazel:bazel-deps (1 packages loaded, 0 targets configured)
INFO: SHA256 (https://github.com/graknlabs/bazel-deps/releases/download/0.3/grakn-bazel-deps-0.3.jar) = 8ea739427526a1719afead62920d3520df60e7595366f357456d204cfd50507c
DEBUG: Rule 'bazel_deps' indicated that a canonical reproducible form can be obtained by modifying arguments sha256 = "8ea739427526a1719afead62920d3520df60e7595366f357456d204cfd50507c"
Analyzing: target @graknlabs_build_tools//bazel:bazel-deps (12 packages loaded, 69 targets configured)
Analyzing: target @graknlabs_build_tools//bazel:bazel-deps (15 packages loaded, 127 targets configured)
Analyzing: target @graknlabs_build_tools//bazel:bazel-deps (17 packages loaded, 335 targets configured)
INFO: Analyzed target @graknlabs_build_tools//bazel:bazel-deps (18 packages loaded, 451 targets configured).
INFO: Found 1 target...
[0 / 1] [Prepa] BazelWorkspaceStatusAction stable-status.txt
Target @graknlabs_build_tools//bazel:bazel-deps up-to-date:
  bazel-bin/external/graknlabs_build_tools/bazel/bazel-deps.jar
  bazel-bin/external/graknlabs_build_tools/bazel/bazel-deps
INFO: Elapsed time: 262.471s, Critical Path: 9.84s
INFO: 3 processes: 2 processwrapper-sandbox, 1 worker.
INFO: Build completed successfully, 7 total actions
INFO: Running command line: bazel-bin/external/graknlabs_build_tools/bazel/bazel-deps generate -r /home/grakn/shared/benchmark/dependencies/maven/../../ -s dependencies/maven/dependencies.bzl -d dependencies/maven/dependencies.yaml
INFO: Build completed successfully, 7 total actions
wrote 81 targets in 46 BUILD files

~~~ Building report-producer-distribution via Bazel ~~~
\n~~~~ Current working directory: /home/grakn/shared/benchmark
+ bazel build //:report-producer-distribution

(there is more output if it does not break at this point)