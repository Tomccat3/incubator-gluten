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

GLUTEN_JAR=/opt/apps/SPARK3/spark3-current/gluten-velox-bundle-spark3.3_2.12-alinux_2.1903_x86_64-1.3.0-SNAPSHOT.jar
SPARK_HOME=/opt/apps/SPARK3/spark3-current/

cat tpcds_parquet.scala | ${SPARK_HOME}/bin/spark-shell \
  --master yarn --deploy-mode client \
  --conf spark.plugins=org.apache.gluten.GlutenPlugin \
  --conf spark.gluten.loadLibFromJar=false \
  --conf spark.driver.extraClassPath=${GLUTEN_JAR} \
  --conf spark.executor.extraClassPath=${GLUTEN_JAR} \
  --conf spark.memory.offHeap.enabled=true \
  --conf spark.memory.offHeap.size=4g \
  --conf spark.gluten.sql.columnar.forceShuffledHashJoin=true \
  --conf spark.shuffle.manager=org.apache.spark.shuffle.sort.ColumnarShuffleManager \
  --num-executors 1 \
  --executor-cores 1 \
  --driver-memory 2g \
  --executor-memory 4g \
  --conf spark.executor.memoryOverhead=1g \
  --conf spark.driver.maxResultSize=2g \
  --conf spark.gluten.sql.columnar.backend.velox.IOThreads=0

  #  --conf spark.driver.extraClassPath=${GLUTEN_JAR} \
  #  --conf spark.executor.extraClassPath=${GLUTEN_JAR} \

  # If there are some "*.so" libs dependencies issues on some specific Distros,
  # try to enable spark.gluten.loadLibFromJar and build your own gluten-thirdparty-lib Jar.
  # e.g.
  #   --conf spark.gluten.loadLibFromJar=true \
  #   --jars /PATH_TO_GLUTEN_HOME/package/target/thirdparty-lib/gluten-thirdparty-lib-ubuntu-22.04-x86_64.jar,
  #          /PATH_TO_GLUTEN_HOME/package/target/gluten-velox-bundle-spark3.3_2.12-ubuntu_22.04_x86_64-1.3.0-SNAPSHOT.jar
