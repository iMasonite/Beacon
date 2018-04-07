<?php

class BeaconPreset extends BeaconObject {
	protected $contents;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'contents';
		return $columns;
	}
	
	protected static function TableName() {
		return 'presets';
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->contents = $row->Field('contents');
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['contents'] = $this->contents;
		$json['resource_url'] = BeaconAPI::URL('/preset.php/' . urlencode($this->ObjectID()));
		return $json;
	}
	
	public function Contents() {
		return $this->contents;
	}
}

?>