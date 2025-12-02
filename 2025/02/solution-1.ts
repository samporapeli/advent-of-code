#!/usr/bin/env -S deno run

// Usage: pbpaste | ./solution-1.ts

// Read input from stdin
let rawInput = "";
const decoder = new TextDecoder();
for await (const chunk of Deno.stdin.readable) {
	rawInput += decoder.decode(chunk);
}

// Split and clean input into commands
const input = rawInput
	.split(",")
	.map(_ => _.trim())
	.filter(_ => _)

// Unwrap ranges
const ids = input
	.flatMap(range => {
		const [start, end] = range.split("-").map(x => parseInt(x))
		return Array.from(Array(end - start + 1))
			.map((_, i) => start + i)
	})

let invalidSum = 0;

const containsSequenceTwice = (id: number) => {
	const str = id.toString()
	const len = str.length
	if (len % 2 !== 0) return false
	const a = str.substring(0, len / 2)
	const b = str.substring(len / 2, len)
	return a === b
}

ids.forEach(id => containsSequenceTwice(id) ? invalidSum += id : undefined)
// ids.forEach(id => console.log({id, "isValid": !containsSequenceTwice(id.toString())}))

console.log(invalidSum)
