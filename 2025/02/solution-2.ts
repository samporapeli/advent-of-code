#!/usr/bin/env -S deno run

// Usage: pbpaste | ./solution-2.ts

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

const isValidId = (idStr: string, seqLength?: number) => {
	if (seqLength === undefined) {
		seqLength = idStr.length - 1
	}
	// Base case - if we got this far, it's a valid id
	if (seqLength === 0) return true
	// Sequence must fit whole number times
	if (idStr.length % seqLength !== 0) return isValidId(idStr, seqLength - 1)

	const seq = idStr.substring(0, seqLength)
	let allMatch = true
	for (let i = 0; i <= idStr.length - seqLength; i += seqLength) {
		const current = idStr.substring(i, i + seqLength)
    const matches = current === seq
		// console.log({ idStr, i, current, seq, seqLength, matches })
		if (!matches) {
			allMatch = false
		}
	}
	if (allMatch) return false
	return isValidId(idStr, seqLength - 1)
}

ids.forEach(id => !isValidId(id.toString()) ? invalidSum += id : undefined)
// ids.forEach(id => console.log(id, isValidId(id.toString())))

console.log(invalidSum)
