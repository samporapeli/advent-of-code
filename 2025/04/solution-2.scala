#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-2.scala

import scala.io.StdIn

object Solution {
  def main(args: Array[String]): Unit = {
    // Parse puzzle input
    val puzzleInput = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => line.split(""))
      .map(line => line.map(value => if (value == "@") 1 else 0))
      .map(line => line.toArray)
      .toArray

    // Determine whether there's roll at (x, y)
    def valueAt(diagram: Array[Array[Int]], x: Int, y: Int): Int = {
      if (x < 0 || y < 0 || x >= diagram(0).length || y >= diagram.length) {
        0
      } else {
        diagram(y)(x)
      }
    }

    def removeRolls(diagram: Array[Array[Int]], alreadyRemoved: Int): Int = {
      val rd = removable(diagram)
      val rdCount = rd
      .map(line => line.sum)
      .sum
      if (rdCount == 0) {
        alreadyRemoved
      } else {
        val newDiagram = diagram.zipWithIndex
          .map((line, y) => line.zipWithIndex.map((value, x) => {
            if (rd(y)(x) == 1) 0 else diagram(y)(x)
          }))
        removeRolls(newDiagram, alreadyRemoved + rdCount)
      }
    }

    def removable(diagram: Array[Array[Int]]): Array[Array[Int]] = diagram
      .map(line => line.zipWithIndex)
      .zipWithIndex
      .map((line, y) => line.map((value, x) => {
        if (value == 1) {
          val neighborCount =
            valueAt(diagram, x - 1, y - 1) +
            valueAt(diagram, x, y - 1) +
            valueAt(diagram, x + 1, y - 1) +
            valueAt(diagram, x - 1, y) +
            valueAt(diagram, x + 1, y) +
            valueAt(diagram, x - 1, y + 1) +
            valueAt(diagram, x, y + 1) +
            valueAt(diagram, x + 1, y + 1)
          if (neighborCount < 4) 1 else 0
          } else {
            0
          }
      }))
  println(removeRolls(puzzleInput, 0))
  }
}
