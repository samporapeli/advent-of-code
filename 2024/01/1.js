import { readAll } from "@std/io";

const input = await readAll(Deno.stdin)
const lines = new TextDecoder().decode(input).split("\n").filter(line => line)

const left = []
const right = []

lines.forEach(line => {
  const split = line.split(/\s/).filter(e => e)
  left.push(Number(split[0]))
  right.push(Number(split[1]))
})

const leftS = left.toSorted((a, b) => a - b)
const rightS = right.toSorted((a, b) => a - b)

let sum = 0
leftS.forEach((_, i) => {
  sum += Math.abs(leftS[i] - rightS[i])
})

console.log(sum)
