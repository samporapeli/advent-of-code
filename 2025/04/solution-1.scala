#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn

object Solution {
  def main(args: Array[String]): Unit = {
    // Parse puzzle input
    val diagram = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => line.split(""))
      .toArray

    // Determine whether there's roll at (x, y)
    def valueAt(x: Int, y: Int): Int = {
      if (x < 0 || y < 0 || x >= diagram(0).length || y >= diagram.length) {
        0
      } else {
        if (diagram(y)(x) == "@") 1 else 0
      }
    }

    // Solve puzzle
    println(diagram
      .map(line => line.zipWithIndex)
      .zipWithIndex
      .map((line, y) => line.map((value, x) => {
        if (value == "@") {
          val neighborCount =
            valueAt(x - 1, y - 1) +
            valueAt(x, y - 1) +
            valueAt(x + 1, y - 1) +
            valueAt(x - 1, y) +
            valueAt(x + 1, y) +
            valueAt(x - 1, y + 1) +
            valueAt(x, y + 1) +
            valueAt(x + 1, y + 1)
          if (neighborCount < 4) 1 else 0
        } else {
          0
        }
      }))
      .map(line => line.sum)
      .sum)
  }
}
