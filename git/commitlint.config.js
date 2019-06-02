module.exports = {
	extends: ['@commitlint/config-conventional'],
	rules: {
		'subject-min-length': [1, 'always', 42]
	}
}
