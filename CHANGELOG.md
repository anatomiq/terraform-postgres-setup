# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.7...v1.1.0) (2025-10-27)


### Features

* **privileges:** Fix example ([5fb1edc](https://github.com/anatomiq/terraform-postgres-setup/commit/5fb1edc955ddef0981249a9a8e2be1cbd4b7a249))
* **privileges:** Refactoring default privileges ([8feca29](https://github.com/anatomiq/terraform-postgres-setup/commit/8feca297eda52a13e3749f3188e48bbe5de07e41))
* **privileges:** Remove schema ([beb1fb9](https://github.com/anatomiq/terraform-postgres-setup/commit/beb1fb9ee983859dc427f8055f665dba3131c56c))

## [1.0.7](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.6...v1.0.7) (2025-10-22)


### Bug Fixes

* adding default USAGE privileges for fdw ([36816c0](https://github.com/anatomiq/terraform-postgres-setup/commit/36816c076e23ccc67d465e05c1cc1c82ac3a0a6a))

## [1.0.6](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.5...v1.0.6) (2025-10-21)


### Bug Fixes

* grant for foreign data wrappers ([92a8cd8](https://github.com/anatomiq/terraform-postgres-setup/commit/92a8cd89d648301d5c601bdfc1d42e0b3fceb7d1))

## [1.0.5](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.4...v1.0.5) (2025-10-20)


### Bug Fixes

* adding extensions block ([2ec71a0](https://github.com/anatomiq/terraform-postgres-setup/commit/2ec71a054dc5e75500b6788b7638312d658a455d))

## [1.0.4](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.3...v1.0.4) (2025-10-15)


### Bug Fixes

* update terraform version ([3d9dda2](https://github.com/anatomiq/terraform-postgres-setup/commit/3d9dda292b3846b31713344afa4be44eb60a5989))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-25)


### Bug Fixes

* adding random password parameters ([6dfd2b2](https://github.com/anatomiq/terraform-postgres-setup/commit/6dfd2b294952cc52b7a616e103e60b2326c3875f))
* complete exampel fix ([c34852f](https://github.com/anatomiq/terraform-postgres-setup/commit/c34852fac34b837fe55f283449b7b7e64847735f))
* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))
* remove unused parameters ([9a8bed7](https://github.com/anatomiq/terraform-postgres-setup/commit/9a8bed7ba1516ee155ea468cdbc6075d3ca3ade1))
* revert password parameters ([bf76dad](https://github.com/anatomiq/terraform-postgres-setup/commit/bf76dadbd07573c8c3d2b95912bd0aee5654afcd))
* trigger release ([c0f4775](https://github.com/anatomiq/terraform-postgres-setup/commit/c0f47751e8e80ea441b4dd1d58a7cd8acdb9b78e))
* trigger release ([a250a22](https://github.com/anatomiq/terraform-postgres-setup/commit/a250a22db4f06932b717030c69bc77947be9f625))
* trigger release ([f38df5b](https://github.com/anatomiq/terraform-postgres-setup/commit/f38df5bc07effa2f302644a3e921d1fa8dd3742e))
* use lookup instead of try ([598a9ba](https://github.com/anatomiq/terraform-postgres-setup/commit/598a9bac9c2bcc36b4b0d376a8871273bffb4286))
* use try instead of coalesce ([2bac334](https://github.com/anatomiq/terraform-postgres-setup/commit/2bac334564c9bf6d54fa7ccb2314378f4ec7a582))
* using coalesce for password parameters ([dc493fb](https://github.com/anatomiq/terraform-postgres-setup/commit/dc493fb351555cc6e90b0cf752284af735c70ba4))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-24)


### Bug Fixes

* adding random password parameters ([6dfd2b2](https://github.com/anatomiq/terraform-postgres-setup/commit/6dfd2b294952cc52b7a616e103e60b2326c3875f))
* complete exampel fix ([c34852f](https://github.com/anatomiq/terraform-postgres-setup/commit/c34852fac34b837fe55f283449b7b7e64847735f))
* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))
* remove unused parameters ([9a8bed7](https://github.com/anatomiq/terraform-postgres-setup/commit/9a8bed7ba1516ee155ea468cdbc6075d3ca3ade1))
* trigger release ([c0f4775](https://github.com/anatomiq/terraform-postgres-setup/commit/c0f47751e8e80ea441b4dd1d58a7cd8acdb9b78e))
* trigger release ([a250a22](https://github.com/anatomiq/terraform-postgres-setup/commit/a250a22db4f06932b717030c69bc77947be9f625))
* trigger release ([f38df5b](https://github.com/anatomiq/terraform-postgres-setup/commit/f38df5bc07effa2f302644a3e921d1fa8dd3742e))
* use lookup instead of try ([598a9ba](https://github.com/anatomiq/terraform-postgres-setup/commit/598a9bac9c2bcc36b4b0d376a8871273bffb4286))
* use try instead of coalesce ([2bac334](https://github.com/anatomiq/terraform-postgres-setup/commit/2bac334564c9bf6d54fa7ccb2314378f4ec7a582))
* using coalesce for password parameters ([dc493fb](https://github.com/anatomiq/terraform-postgres-setup/commit/dc493fb351555cc6e90b0cf752284af735c70ba4))

## [1.0.4](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.3...v1.0.4) (2025-09-24)


### Bug Fixes

* use lookup instead of try ([598a9ba](https://github.com/anatomiq/terraform-postgres-setup/commit/598a9bac9c2bcc36b4b0d376a8871273bffb4286))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-24)


### Bug Fixes

* adding random password parameters ([6dfd2b2](https://github.com/anatomiq/terraform-postgres-setup/commit/6dfd2b294952cc52b7a616e103e60b2326c3875f))
* complete exampel fix ([c34852f](https://github.com/anatomiq/terraform-postgres-setup/commit/c34852fac34b837fe55f283449b7b7e64847735f))
* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))
* remove unused parameters ([9a8bed7](https://github.com/anatomiq/terraform-postgres-setup/commit/9a8bed7ba1516ee155ea468cdbc6075d3ca3ade1))
* use try instead of coalesce ([2bac334](https://github.com/anatomiq/terraform-postgres-setup/commit/2bac334564c9bf6d54fa7ccb2314378f4ec7a582))
* using coalesce for password parameters ([dc493fb](https://github.com/anatomiq/terraform-postgres-setup/commit/dc493fb351555cc6e90b0cf752284af735c70ba4))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-24)


### Bug Fixes

* adding random password parameters ([6dfd2b2](https://github.com/anatomiq/terraform-postgres-setup/commit/6dfd2b294952cc52b7a616e103e60b2326c3875f))
* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))
* remove unused parameters ([9a8bed7](https://github.com/anatomiq/terraform-postgres-setup/commit/9a8bed7ba1516ee155ea468cdbc6075d3ca3ade1))
* using coalesce for password parameters ([dc493fb](https://github.com/anatomiq/terraform-postgres-setup/commit/dc493fb351555cc6e90b0cf752284af735c70ba4))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-24)


### Bug Fixes

* adding random password parameters ([6dfd2b2](https://github.com/anatomiq/terraform-postgres-setup/commit/6dfd2b294952cc52b7a616e103e60b2326c3875f))
* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))
* remove unused parameters ([9a8bed7](https://github.com/anatomiq/terraform-postgres-setup/commit/9a8bed7ba1516ee155ea468cdbc6075d3ca3ade1))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-24)


### Bug Fixes

* adding random password parameters ([6dfd2b2](https://github.com/anatomiq/terraform-postgres-setup/commit/6dfd2b294952cc52b7a616e103e60b2326c3875f))
* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))

## [1.0.3](https://github.com/anatomiq/terraform-postgres-setup/compare/v1.0.2...v1.0.3) (2025-09-24)


### Bug Fixes

* correct password lookup for multi-db roles ([9b6943d](https://github.com/anatomiq/terraform-postgres-setup/commit/9b6943d3a450cace57244ac3e009a456b7c4f4e8))
* correct password lookup for multi-db roles ([b73cdc7](https://github.com/anatomiq/terraform-postgres-setup/commit/b73cdc72c172e0eaf3687b6c9cf7d3f9b1a7d4e0))
* correct password lookup for multi-db roles ([60e96f8](https://github.com/anatomiq/terraform-postgres-setup/commit/60e96f8b97d0ecdfbefe941209f05f1263763205))
* correct password lookup for multi-db roles ([4ad52cf](https://github.com/anatomiq/terraform-postgres-setup/commit/4ad52cf8f20fbf55fa507ea3154b206a621c98cc))
