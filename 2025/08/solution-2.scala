#!/usr/bin/env -S scala-cli -S 3

// Usage: pbpaste | ./solution-2.scala

import scala.io.StdIn
import scala.collection.mutable.ArrayBuffer

case class Jbox(x: Int, y: Int, z: Int)
case class Distance(a: Int, b: Int, d: Double)
case class JboxPair(a: Jbox, b: Jbox)

object Solution:
  def d(a: Jbox, b: Jbox) =
    Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2) + Math.pow(a.z - b.z, 2))
  def main(args: Array[String]): Unit =
    // Parse puzzle input
    val jboxes = Iterator.continually(StdIn.readLine())
      .takeWhile(_ != null)
      .filter(!_.isBlank)
      .map(line =>
        val coords = line.split(",").map(Integer.parseInt(_))
        Jbox(coords(0), coords(1), coords(2))
      )
      .toVector
    // Calculate distances between each box, order shortest first
    val distances = (0 until jboxes.length).flatMap(y =>
      (0 until jboxes.length).map(x =>
        if (y >= x) null
        else Distance(y, x, d(jboxes(y), jboxes(x)))
      )
    ).filter(_ != null)
    .sortBy(_.d)

    // Count circuits and connect jboxes
    val circuits = jboxes.map(Set(_)).to(ArrayBuffer)
    val boxesToAdd = distances
      .map(d => JboxPair(jboxes(d.a), jboxes(d.b)))
    boxesToAdd.takeWhile(pair =>
      val iA = circuits.indexWhere(set => set.contains(pair.a))
      val iB = circuits.indexWhere(set => set.contains(pair.b))
      circuits(iA) = circuits(iA) ++ circuits(iB)
      if (iA != iB) circuits.remove(iB)
      if (circuits.length == 1) println(BigInt(pair.a.x) * BigInt(pair.b.x))
      circuits.length != 1
    )
