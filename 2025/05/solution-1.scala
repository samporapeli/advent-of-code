#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-1.scala

import scala.io.StdIn

case class IdRange(from: BigInt, to: BigInt)

object Solution {
  def bigRange(from: BigInt, to: BigInt) = Iterator.iterate(from) { _ + 1 }.takeWhile(_ <= to)
  def main(args: Array[String]): Unit = {
    // Parse puzzle input
    val freshIdRanges = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != "")
      .filter(!_.isBlank)
      .map(range => IdRange(BigInt(range.split("-")(0)), BigInt(range.split("-")(1))))
      .toArray

    val ids = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(BigInt(_))
      .toArray

    // Check which ids are fresh
    println(ids.count(id => freshIdRanges.exists(range => id >= range.from && id <= range.to)))
  }
}
