/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import org.apache.spark.sql.execution.debug._
import scala.io.Source
import java.io.File
import java.util.Arrays
import sys.process._


def time[R](block: => R): R = {
    val t0 = System.nanoTime()
    val result = block    // call-by-name
    val t1 = System.nanoTime()
    println("Elapsed time: " + "%.2f".format((t1 - t0)/1000000000.0) + " seconds")
    result
}

// Main program to run TPC-H testing
for (i <- 1 to 3) {
  val fileContents = Source.fromFile("sql.sql").getLines.filter(!_.startsWith("--")).mkString("\n")
  println(fileContents)
  try {
    time{spark.sql(fileContents).collect}
    // spark.sql(fileContents).explain
    Thread.sleep(2000)
  } catch {
    case e: Exception => println(e)
  }
}
