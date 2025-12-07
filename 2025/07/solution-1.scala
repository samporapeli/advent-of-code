#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn
import scala.collection.mutable.ArrayBuffer

object Solution {
  def main(args: Array[String]): Unit = {
    // Parse puzzle input
    val manifold = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => line.split("").filter(!_.isBlank).to(ArrayBuffer))
      .to(ArrayBuffer)

    // Trace the beam and update manifold as the beam traverses
    var splits = 0
    (1 until manifold.length).foreach(y => {
      (0 until manifold(0).length).foreach(x => {
        val current = manifold(y)(x)
        val above = manifold(y - 1)(x)
        if (current == "." && (above == "|" || above == "S")) manifold(y)(x) = "|"
        else if (current == "^" && (above == "|" || above == "S")) then
          manifold(y)(x - 1) = "|"
          manifold(y)(x + 1) = "|"
          splits += 1
      })
    })
    // manifold.foreach(line => (line ++ "\n").foreach(print(_)))
    println(splits)
  }
}
