#!/usr/bin/env -S deno run

// Usage: pbpaste | ./solution-1.js

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

// Initial dial position
let position = 50
let password = 0

for (let line of input) {
	const direction = line.charAt(0) === "R" ? 1 : -1
	const amount = Number.parseInt(line.substring(1))
	position += direction * amount
	position = position % 100
	if (position < 0) position += 100
	if (position === 0) password++
}

console.log(password)
