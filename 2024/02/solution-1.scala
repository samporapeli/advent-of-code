#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn

object Solution {
  def main(args: Array[String]): Unit = {
    println(Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .map(_.trim)
      .filter(!_.isBlank)
      .map(report => report.split(" ").map(Integer.parseInt(_)))
      // Calculate the difference between levels
      .map(report => report.dropRight(1).zip(report.drop(1)))
      .map(report => report.map((a, b) => b - a))
      // Rule 1: all must be increasing or decreasing
      .filter(report => report.forall(_ > 0) || report.forall(_ < 0))
      // Rule 2: difference min 1, max 3
      .filter(report => report.forall(diff => Math.abs(diff) >= 1 && Math.abs(diff) <= 3))
      .length
    )
  }
}
