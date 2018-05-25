# sohungry 0.4.0

* Added a `NEWS.md` file to track changes to the package.

* The `format` parameter was introduced to the `so_isotopes` function. The current default `format` is "wide", in which case the data will be formatted with one row per record and multiple measurements (of different isotopes) per row. If `format` is "mv", the data will be in measurement-value (long) format with multiple rows per original record, split so that each different isotope measurement appears in its own row. Note that "mv" will become the default (and possibly only) option in a later release. Currently, `record_id` values in measurement-value format are not unique (they follow the `record_id` values from the wide format). The `record_id` values in measurement-value format are likely to change in a future release.

