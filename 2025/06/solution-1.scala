#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn

object Solution {
  def main(args: Array[String]): Unit = {
    // Parse puzzle input
    val input = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => line.split(" ").filter(!_.isBlank))
      .toVector

    // Solve
    println((0 until input(0).length).map(x => {
      val operation = input.last(x)
      val values = (0 until input.length - 1).map(y => BigInt(input(y)(x)))
      if (operation == "+") values.sum else values.product
    }).sum)
  }
}
