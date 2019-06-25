<h1>Unlock Key</h1>
<div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2 class="panel-title">
                <a data-toggle="collapse" href="#information">
                    Information
                </a>
            </h2>
        </div>
        <div id="information" class="panel-collapse collapse">
            <div class="panel-body">
                <p>
                    Entering the password will allow changes to synchronise to servers.
                    It will synchronise every change and is not restricted to the current user.
                    The password is cached for 15 minutes. 
                    Afterwards it will be necessary to enter the password again.
                </p>
            </div>
        </div>
    </div>
    <p>
        Please enter the password for the ssh key:
    </p>
    <form method="post" action="<?php outurl($this->data->relative_request_url) ?>" class="form-horizontal">
        <?php out($this->get('active_user')->get_csrf_field(), ESC_NONE) ?>
        <div class="form-group">
        <div class="col-md form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" autofocus require>
            </div>
            <div class="col-md form-group">
                <button type="submit" name="password_entry" value="1" class="btn btn-primary">Confirm</button>
                <a href="" class="navigate-back">Cancel</a>
            </div>
        </div>
    </form>
</div>
