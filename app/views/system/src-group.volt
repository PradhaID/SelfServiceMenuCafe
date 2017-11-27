<table class="ui mini magenta striped selectable table">
    <thead>
    <tr>
        <th>Group ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Last Updated</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    {% for group in groups %}
        <tr>
            <td>{{ group.id }}</td>
            <td>{{ group.name }}</td>
            <td>{{ group.description }}</td>
            <td>{{ group.updated_at|dateFormat }}</td>
            <td>
                <a href="{{ url('system/group/edit/') }}{{  group.id }}" title="Edit"><i class="edit icon"></i> </a>
                <a href="{{ url('system/group/role/') }}{{  group.id|encode }}" title="Roles"><i class="options icon"></i> </a>
            </td>
        </tr>
    {% endfor %}
    </tbody>
</table>
<div class="ui divider"></div>