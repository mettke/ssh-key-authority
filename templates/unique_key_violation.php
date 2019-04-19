<?php
$e = $this->get('exception');
?>
<h1>Naming conflict</h1>
<div class="alert alert-danger">
<?php if(count($e->fields) == 1) { ?>
<p>The <?php out(str_replace('_', ' ', implode(',', $e->fields)))?> "<?php out(implode(',', $e->values))?>" already exists. Please <a href="" class="navigate-back">go back</a> and try again.</p>
<?php } else { ?>
<p>The values you provided are in conflict with existing records. Please <a href="" class="navigate-back">go back</a> and try again.</p>
<?php } ?>
</div>
