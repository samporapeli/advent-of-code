#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn
import scala.collection.mutable.ArrayBuffer

object Solution {
  def main(args: Array[String]): Unit = {
    // Parse puzzle input
    // Vector[String] ie. just input line strings in a list
    val input = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line => line)
      .toVector

    var operation = ' '
    val operations = (0 until input(0).length).map(x => {
      operation = if (input.last(x) != ' ') input.last(x) else operation
      // map the values of a column
      val value = (0 until input.length - 1).map(y => input(y)(x)).mkString("").trim
      if (value.isBlank) operation.toString else value
    }).toVector ++ Vector(operation.toString)

    var sum = BigInt(0)
    val current = ArrayBuffer[BigInt]()
    operations.foreach(o => {
      if (o == "*") then
        sum += current.product
        current.clear()
      else if (o == "+") then
        sum += current.sum
        current.clear()
      else
        current += BigInt(o)
    })
    println(sum)
  }
}
