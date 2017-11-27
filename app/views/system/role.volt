<div class="ui middle aligned equal width stackable grid">
    <div class="equal width row">
        <div class="column">
            <h1 class="ui header">
                <i class="options icon"></i>
                <div class="content">
                    Roles
                </div>
            </h1>
        </div>
        <div class="right aligned column">
            <a class="ui small magenta button" href="{{ url('system/group/') }}"><i class="angle left icon"></i> Back</a>
        </div>
    </div>
</div>
<div class="ui divider"></div>
<div class="ui form">
    <div class="ui grid">
        {% for role in roles %}
            <div class="four wide column">
                <ul class="roles">
                    <li>
                        <div class="ui checkbox">
                            <input type="checkbox" name="role" value="{{ role.id }}" id="{{ role.id }}" class="role" <?= haveRole(decode($id), $role->id) ? 'checked' : ''; ?> >
                            <label for="{{ role.id }}" title="{{ role.description }}">{{ role.name }}</label>
                        </div>
                        <ul>
                            <?php
                                $subroles=Roles::find(array("conditions"=>"parent='".intval($role->id)."'", "order"=>"id"));
                            ?>
                            {% for sub in subroles %}
                                <li>
                                    <div class="ui checkbox">
                                        <input type="checkbox" name="example" value="{{ sub.id }}" id="{{ sub.id }}" class="role" <?php if (haveRole(decode($id), $sub->id)){ ?>checked<?php } ?> >
                                        <label for="{{ sub.id }}" title="{{ sub.description }}">{{ sub.name }}</label>
                                    </div>
                                </li>
                            {% endfor %}
                        </ul>
                    </li>
                </ul>
            </div>
        {% endfor %}
    </div>
</div>
<script>
    $(document).ready(function(){
        $('.role').on('click', function(){
            $.post( "{{ url('system/group/role/') }}{{ id }}", { group: '{{ id }}', role: $(this).attr('value'), status: this.checked })
                    .done(function( data ) {
                        alert( "Data Loaded: " + data );
                    });
        });
    });
</script>