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

const n = (num) => right.reduce((count, current) => count += Number(current === num), 0)


let similarity = 0
left.forEach((num) => {
  similarity += num * n(num)
})

console.log(similarity)
