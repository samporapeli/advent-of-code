#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-2.scala

import scala.io.StdIn
import scala.collection.mutable.ArrayBuffer

object Solution:
  def traced(manifoldVector: Vector[Vector[Char]]): Vector[Vector[Char]] =
    val manifold = manifoldVector.map(_.to(ArrayBuffer)).to(ArrayBuffer)
    (1 until manifold.length).foreach(y => {
      (0 until manifold(0).length).foreach(x => {
        val current = manifold(y)(x)
        val above = manifold(y - 1)(x)
        if (current == '.' && above == '|') manifold(y)(x) = '|'
        else if (current == '^' && above == '|') then
          manifold(y)(x - 1) = '|'
          manifold(y)(x + 1) = '|'
      })
    })
    manifold.map(_.toVector).toVector

  def main(args: Array[String]): Unit =
    // Parse puzzle input
    val manifold = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => line.replace("S", "|").toVector)
      .toVector

    // Trace all beam possibilities to create a fully traced manifold
    val tracedManifold = traced(manifold)

    // Create a lookup table for storing intermediate timeline counts
    val v = ArrayBuffer.fill(manifold.length)(null).map(_ => ArrayBuffer.fill(manifold(0).length)(BigInt("0")))
    // Method for checking the last result in lookup table
    def getLast(x: Int, y: Int): BigInt =
      if (y >= v.length) 1 // base case
      else if (v(y)(x) > 0) v(y)(x) // non-zero = earlier result
      else getLast(x, y + 1) // traverse recursively to get a non-0 value

    // Traverse the manifold from bottom to top, accumulate sum of timelines
    (1 until manifold.length)
      .reverse
      .foreach(y =>
        (0 until manifold(0).length)
          .foreach(x =>
            val current = tracedManifold(y)(x)
            if (current == '^') then
              v(y)(x) = getLast(x - 1, y) + getLast(x + 1, y)
        )
      )
    // Get and print the topmost value
    println(v.flatten.find(_ > 0).get)
