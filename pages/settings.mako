<%include file="/support/header.mako" args="environ=environ, title='Settings'"/>\
<%namespace module="toolserver.misc" import="get_bot, parse_cookies"/>\
<%namespace module="toolserver.sites" import="get_sites"/>\
<% cookies = parse_cookies(environ) %>
<% langs, projects = get_sites(get_bot()) %>
            <h1>Settings</h1>
            <p>This page contains some configurable options for this Toolserver site. Settings are saved as cookies. You can view and delete all cookies generated by this site at the bottom of this page.</p>
            <h2>Options</h2>
            <table>
                <tr>
                    <form action="${environ['PATH_INFO']}" method="post">
                        <input type="hidden" name="action" value="setDefaultSite">
                        <td>Default site:</td>
                        <td>
                            <tt>http://</tt>
                            <select name="lang">
                                % for code, name in langs:
                                    % if "EarwigDefaultLang" in cookies and code == cookies["EarwigDefaultLang"].value:
                                        <option value="${code}" selected="selected">${name}</option>
                                    % else:
                                        <option value="${code}">${name}</option>
                                    % endif
                                % endfor
                            </select>
                            <tt>.</tt>
                            <select name="project">
                                % for code, name in projects:
                                    % if "EarwigDefaultProject" in cookies and code == cookies["EarwigDefaultProject"].value:
                                        <option value="${code}" selected="selected">${name}</option>
                                    % else:
                                        <option value="${code}">${name}</option>
                                    % endif
                                % endfor
                            </select>
                            <tt>.org</tt>
                        </td>
                        <td><button type="submit">Save</button></td>
                    </form>
                </tr>
                <tr>
                    <td>Background:</td>
                </tr>
            </table>
            <h2>Cookies</h2>
            % if cookies:
                <ul>
                % for cookie in cookies:
                    <li>
                        <tt>${cookie.name | h}</tt>: <tt>${cookie.value | h}</tt>
                        <form action="${environ['PATH_INFO']}" method="post">
                            <input type="hidden" name="action" value="deleteCookie">
                            <input type="hidden" name="cookie" value="${cookie.name | h}">
                            <button type="submit">Delete</button>
                        </form>
                    </li>
                % endfor
                </ul>
                <form action="${environ['PATH_INFO']}" method="post">
                    <input type="hidden" name="action" value="deleteCookie">
                    <input type="hidden" name="all" value="1">
                    <button type="submit">Delete all</button>
                </form>
            % else:
                <p>No cookies!</p>
            % endif
<%include file="/support/footer.mako" args="environ=environ"/>
