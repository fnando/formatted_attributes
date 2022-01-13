# Changelog

<!--
Prefix your message with one of the following:

- [Added] for new features.
- [Changed] for changes in existing functionality.
- [Deprecated] for soon-to-be removed features.
- [Removed] for now removed features.
- [Fixed] for any bug fixes.
- [Security] in case of vulnerabilities.
-->

## v0.2.0 - 2022-01-13

- [Changed] The converting methods have been renamed from `format_from_*` and
  `format_to_*` to `convert_from_*` and `convert_with_*`, respectively.
- [Changed] Now we call `super` whenever a new value is assigned using
  `:attr=(value)`. Previously this was calling `write_attribute`, but it didn't
  support non-ActiveRecord classes.
- [Added] Support non-ActiveRecord classes.

## v0.1.0 - 2010-11-06

- Initial release.
