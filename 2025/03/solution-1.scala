#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn

object Solution {
  def main(args: Array[String]): Unit = {
    println(Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line =>
        val joltages = line.map(_.asDigit)
        val maxValue = joltages.dropRight(1).max
        val maxValueFirstIndex = joltages.indexOf(maxValue)
        val secondDigit = joltages.drop(maxValueFirstIndex + 1).max
        val bankJoltage = Integer.parseInt(maxValue.toString() + secondDigit.toString())
        // println(bankJoltage)
        bankJoltage
      )
      .sum)
  }
}
