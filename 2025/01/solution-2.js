#!/usr/bin/env -S deno run

// Usage: pbpaste | ./solution-2.js

// Read input from stdin
let rawInput = "";
const decoder = new TextDecoder();
for await (const chunk of Deno.stdin.readable) {
	rawInput += decoder.decode(chunk);
}

// Split and clean input into commands
const input = rawInput
	.split("\n")
	.map(_ => _.trim())
	.filter(_ => _)

// "simplify" the input to just contain L1 and R1 instructions
// it's stupid but it works
const newInput = input
	.flatMap(instruction => {
		const direction = instruction.charAt(0)
		const amount = Number.parseInt(instruction.substring(1))
		return Array.from(Array(amount)).map(_ => `${direction}1`)
	})

// Initial dial position
let position = 50
let password = 0

for (let line of newInput) {
	const direction = line.charAt(0) === "R" ? 1 : -1
	const amount = 1
	position += direction * amount
	position = position % 100
	if (position < 0) position += 100
	if (position === 0) password++
}

console.log(password)
