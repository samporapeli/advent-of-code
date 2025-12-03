#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn

object Solution {
  def isSafe(report: Array[Int]) = {
    (1 to report.length).exists(i => {
      val r = report.take(i - 1) ++ report.takeRight(report.length - i)
      // Calculate the difference between levels
      val diffs = r.dropRight(1).zip(r.drop(1))
        .map((a, b) => b - a)
      // Rule 1: all must be increasing or decreasing (tolerate 1 bad value)
      val r1 = diffs.forall(_ > 0) || diffs.forall(_ < 0)
      // Rule 2: difference min 1, max 3
      val r2 = diffs.forall(diff => Math.abs(diff) >= 1 && Math.abs(diff) <= 3)
      r1 && r2
    })
  }
  def main(args: Array[String]): Unit = {
    println(Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .map(_.trim)
      .filter(!_.isBlank)
      .map(report => report.split(" ").map(Integer.parseInt(_)))
      .filter(isSafe(_))
      .length
    )
  }
}
