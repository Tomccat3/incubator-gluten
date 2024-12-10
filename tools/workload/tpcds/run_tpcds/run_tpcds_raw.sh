# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

GLUTEN_JAR=/usr/lib/spark/jars/gluten-velox-bundle-spark3.5_2.12-amzn_2_x86_64-1.3.0-SNAPSHOT.jar
SPARK_HOME=/usr/lib/spark

cat tpcds_parquet.scala | ${SPARK_HOME}/bin/spark-shell \
  --master yarn --deploy-mode client \
  --num-executors 2 \
  --executor-cores 2 \
  --driver-memory 2g \
  --executor-memory 8g \
  --conf spark.executor.memoryOverhead=2g \
  --conf spark.driver.maxResultSize=2g \
#  --conf spark.executorEnv.JAVA_HOME="/usr/lib/jvm/java-1.8.0" \
#  --conf spark.yarn.appMasterEnv.JAVA_HOME="/usr/lib/jvm/java-1.8.0" \

  # If there are some "*.so" libs dependencies issues on some specific Distros,
  # try to enable spark.gluten.loadLibFromJar and build your own gluten-thirdparty-lib Jar.
  # e.g.
  #   --conf spark.gluten.loadLibFromJar=true \
  #   --jars /PATH_TO_GLUTEN_HOME/package/target/thirdparty-lib/gluten-thirdparty-lib-ubuntu-22.04-x86_64.jar,
  #          /PATH_TO_GLUTEN_HOME/package/target/gluten-velox-bundle-spark3.3_2.12-ubuntu_22.04_x86_64-1.3.0-SNAPSHOT.jar
