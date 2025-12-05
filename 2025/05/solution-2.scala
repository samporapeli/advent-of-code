#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-2.scala

import scala.io.StdIn

case class IdRange(from: BigInt, to: BigInt)

object Solution {
  def main(args: Array[String]): Unit = {
    var ranges = scala.collection.mutable.ArrayBuffer[IdRange]()
    Iterator.continually(StdIn.readLine())
      .takeWhile(_ != "")
      .filter(!_.isBlank)
      .foreach(range => {
        val List(from, to) = range.split("-").map(BigInt(_)).toList
        val firstOverlapIndex = ranges.indexWhere(x => x.from <= from && from <= x.to)
        val lastOverlapIndex = ranges.indexWhere(x => x.from <= to && to <= x.to)
        val newFrom = if (firstOverlapIndex >= 0) ranges(firstOverlapIndex).from else from
        val newTo = if (lastOverlapIndex >= 0) ranges(lastOverlapIndex).to else to
        ranges = ranges.takeWhile(_.from < newFrom) ++ Vector(IdRange(newFrom, newTo)) ++ ranges.dropWhile(_.to <= newTo)
      })

    println(ranges.map(x => x.to - x.from + 1).sum)
  }
}
