<table class="ui mini magenta striped selectable table">
    <thead>
    <tr>
        <th>No</th>
        <th>Floor</th>
        <th>Description</th>
        <th>Capacity</th>
        <th>Smoke</th>
        <th>Position</th>
        <th>Available</th>
        <th>Created</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for table in tables %}
        <tr>
            <td>{{ table.id }}</td>
            <td>{{ table.floor }}</td>
            <td>{{ table.description }}</td>
            <td>{{ table.capacity }} Person{% if table.capacity>1 %}s{% endif %}</td>
            <td>{% if table.smoke %}Yes{% else %}No{% endif %}</td>
            <td>x{{ table.position_x }} y{{ table.position_y }}</td>
            <td>{% if table.available %}Yes{% else %}No{% endif %}</td>
            <td>{{ table.created_at|dateTimeFormat }}</td>
            <td><a href="{{ url('content/table/edit/') }}{{  table.id|encode }}">Edit</a></td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>