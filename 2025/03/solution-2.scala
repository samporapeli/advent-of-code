#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-2.scala

import scala.io.StdIn
import scala.collection.mutable.ArrayBuffer

object Solution {
  def findLargest(joltages: Array[Int], currentJoltage: String, remaining: Int): BigInt = {
    if (remaining == 0) return BigInt(currentJoltage)
    val maxValue = joltages.dropRight(remaining - 1).max
    val maxValueIndex = joltages.dropRight(remaining - 1).indexOf(maxValue)
    findLargest(joltages.drop(maxValueIndex + 1), currentJoltage + maxValue, remaining - 1)
  }

  def main(args: Array[String]): Unit = {
    println(Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => findLargest(line.map(_.asDigit).toArray, "", 12))
      .sum)
  }
}
