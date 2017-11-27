<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="key icon"></i>
                <div class="content">
                    Change Password
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('profile/') }}"><i class="angle left icon"></i> Back</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
<form class="ui form" method="post" action="{{ url('profile/password') }}">
    <div class="fields">
        <div class="three wide field">
            <label>Old Password</label>
            <input type="password" name="old" placeholder="Old Password">
        </div>
        <div class="three wide field">
            <label>New Password</label>
            <input type="password" name="new" placeholder="New Password">
        </div>
        <div class="three wide field">
            <label>Repeat Password</label>
            <input type="password" name="repeat"  placeholder="Repeat Password">
        </div>
    </div>
    <div class="field">
        <button type="submit" class="ui magenta button"><i class="save icon"></i> Change</button>
    </div>
</form>