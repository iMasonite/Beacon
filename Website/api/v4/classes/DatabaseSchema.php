<?php

namespace BeaconAPI\v4;
use Exception;

class DatabaseSchema {
	const OptionDistinct = 1;

	protected $schema = 'public';
	protected $table = '';
	protected $writeableTable = '';
	protected $primaryColumn = null;
	protected $columns = [];
	protected $properties = [];
	protected $joins = [];
	protected bool $distinct = false;

	public function __construct(string $schema, string $table, array $definitions, array $joins = [], int $options = 0) {
		$this->schema = $schema;
		$this->table = $table;
		$this->writeableTable = $table;
		foreach ($definitions as $definition) {
			$this->AddColumn($definition);
		}
		$this->joins = $joins;
		$this->distinct = ($options & self::OptionDistinct) === self::OptionDistinct;
	}

	public function Schema(): string {
		return $this->schema;
	}

	public function SetSchema(string $schema): void {
		$this->schema = $schema;
	}

	public function Table(): string {
		return $this->table;
	}

	public function SetTable(string $table, bool $updateWriteable = true): void {
		$this->table = $table;
		if ($updateWriteable) {
			$this->writeableTable = $table;
		}
	}

	public function WriteableTable(): string {
		return $this->schema . '.' . $this->writeableTable;
	}

	public function SetWriteableTable(string $table): void {
		$this->writeableTable = $table;
	}

	public function PrimaryColumn(): DatabaseObjectProperty {
		return $this->primaryColumn;
	}

	public function SetPrimaryColumn(string|DatabaseObjectProperty $column): void {
		$previousKey = $this->primaryColumn;
		if (is_null($previousKey) === false) {
			if (array_key_exists($previousKey->ColumnName(), $this->columns)) {
				unset($this->columns[$previousKey->ColumnName()]);
			}
			if (array_key_exists($previousKey->PropertyName(), $this->properties)) {
				unset($this->columns[$previousKey->PropertyName()]);
			}
		}

		$this->AddColumn($column);
	}

	public function Distinct(): bool {
		return $this->distinct;
	}

	public function SetDistinct(bool $distinct): void {
		$this->distinct = $distinct;
	}

	public function PrimarySelector(): string {
		return $this->Selector($this->primaryColumn);
	}

	public function PrimaryAccessor(): string {
		return $this->Accessor($this->primaryColumn);
	}

	public function PrimarySetter(string|int $placeholder): string {
		return $this->Setter($this->primaryColumn, $placeholder);
	}

	public function Selector(string|DatabaseObjectProperty $column): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}

		return $column->Selector($this->table);
	}

	public function Accessor(string|DatabaseObjectProperty $column): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}

		return $column->Accessor($this->table);
	}

	// This doesn't do much, it's just for API consistency
	public function Setter(string|DatabaseObjectProperty $column, string|int $placeholder): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}

		return $column->Setter($placeholder);
	}

	public function Comparison(string|DatabaseObjectProperty $column, string $operator, string|int $placeholder, mixed &$value = null): string {
		if (is_string($column)) {
			$columnName = $column;
			$column = $this->Column($columnName) ?? $this->Property($columnName);
			if (is_null($column)) {
				throw new Exception("Unknown column {$columnName}");
			}
		}

		if (is_int($placeholder)) {
			$placeholder = '$' . $placeholder;
		}

		if ($operator === 'ILIKE') {
			$value = '%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $value ?? '') . '%';
			return $column->Accessor($this->table) . ' ILIKE ' . $placeholder;
		} elseif ($operator === 'LIKE') {
			$value = '%' . str_replace(['%', '_', '\\'], ['\\%', '\\_', '\\\\'], $value ?? '') . '%';
			return $column->Accessor($this->table) . ' LIKE ' . $placeholder;
		} else {
			return $column->Accessor($this->table) . ' ' . $operator . ' ' . $placeholder;
		}
	}

	public function AddColumn(string|DatabaseObjectProperty $column): void {
		if (is_string($column)) {
			$column = new DatabaseObjectProperty($column);
		}

		if (array_key_exists($column->PropertyName(), $this->properties) === false) {
			$this->properties[$column->PropertyName()] = $column;
		}
		if (array_key_exists($column->ColumnName(), $this->columns) === false) {
			$this->columns[$column->ColumnName()] = $column;
		}

		if ($column->IsPrimaryKey()) {
			$this->primaryColumn = $column;
		}
	}

	public function AddColumns(array $columns): void {
		foreach ($columns as $column) {
			$this->AddColumn($column);
		}
	}

	public function AddJoin(string $join): void {
		if (in_array($join, $this->joins) === false) {
			$this->joins[] = $join;
		}
	}

	public function Column(string $columnName): ?DatabaseObjectProperty {
		if ($columnName === 'primaryKey') {
			return $this->primaryColumn;
		}
		if (array_key_exists($columnName, $this->columns)) {
			return $this->columns[$columnName];
		}
		return null;
	}

	public function HasProperty(string $propertyName): bool {
		if ($propertyName === 'primaryKey') {
			return true;
		}
		return array_key_exists($propertyName, $this->properties);
	}

	public function Property(string $propertyName): ?DatabaseObjectProperty {
		if ($propertyName === 'primaryKey') {
			return $this->primaryColumn;
		}
		if (array_key_exists($propertyName, $this->properties)) {
			return $this->properties[$propertyName];
		}
		return null;
	}

	public function FromClause(): string {
		return str_replace(['%%SCHEMA%%', '%%TABLE%%'], [$this->schema, $this->table], implode(' ', array_merge(["{$this->schema}.{$this->table}"], $this->joins)));
	}

	public function SelectColumns(): string {
		$selectors = [];
		foreach ($this->columns as $definition) {
			$selectors[] = $definition->Selector($this->table);
		}
		return ($this->distinct ? 'DISTINCT ' : '') . implode(', ', $selectors);
	}

	public function EditableColumns(int $flags): array {
		$columns = [];
		foreach ($this->columns as $columnName => $definition) {
			if ($definition->IsEditable($flags)) {
				$columns[] = $definition;
			}
		}
		return $columns;
	}

	public function RequiredColumns(): array {
		$columns = [];
		foreach ($this->columns as $columnName => $definition) {
			if ($definition->IsRequired()) {
				$columns[] = $definition;
			}
		}
		return $columns;
	}
}

?>
