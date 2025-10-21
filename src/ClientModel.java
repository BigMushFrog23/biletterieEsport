import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClientModel implements Model {
    private Integer clientId;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String city;
    private Timestamp createdAt;

    @Override
    public void getAll() {
        String sql = "SELECT * FROM clients ORDER BY last_name, first_name";
        List<ClientModel> clients = new ArrayList<>();

        try (var conn = MySQLConnection.connect();
            var stmt = conn.createStatement();
            var rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                ClientModel client = new ClientModel();
                client.setClientId(rs.getInt("client_id"));
                client.setFirstName(rs.getString("first_name"));
                client.setLastName(rs.getString("last_name"));
                client.setEmail(rs.getString("email"));
                client.setPhone(rs.getString("phone"));
                client.setCity(rs.getString("city"));
                client.setCreatedAt(rs.getTimestamp("created_at"));
                
                clients.add(client);
                System.out.println(client);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void getId(Integer id) {
        String sql = "SELECT * FROM clients WHERE client_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    this.clientId = rs.getInt("client_id");
                    this.firstName = rs.getString("first_name");
                    this.lastName = rs.getString("last_name");
                    this.email = rs.getString("email");
                    this.phone = rs.getString("phone");
                    this.city = rs.getString("city");
                    this.createdAt = rs.getTimestamp("created_at");
                    
                    System.out.println(this);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void updateRowId(Integer id, String[] newValues) {
        String sql = "UPDATE clients SET first_name = ?, last_name = ?, email = ?, phone = ?, city = ? WHERE client_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newValues[0]); // first_name
            stmt.setString(2, newValues[1]); // last_name
            stmt.setString(3, newValues[2]); // email
            stmt.setString(4, newValues[3]); // phone
            stmt.setString(5, newValues[4]); // city
            stmt.setInt(6, id);
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) mise(s) à jour");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void deleteRowId(Integer id) {
        String sql = "DELETE FROM clients WHERE client_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) supprimée(s)");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void insertNewRow(String[] values) {
        String sql = "INSERT INTO clients (first_name, last_name, email, phone, city) VALUES (?, ?, ?, ?, ?)";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, values[0]); // first_name
            stmt.setString(2, values[1]); // last_name
            stmt.setString(3, values[2]); // email
            stmt.setString(4, values[3]); // phone
            stmt.setString(5, values[4]); // city
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) insérée(s)");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    // Getters et Setters
    public Integer getClientId() { return clientId; }
    public void setClientId(Integer clientId) { this.clientId = clientId; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getFullName() {
        return firstName + " " + lastName;
    }

    @Override
    public String toString() {
        return String.format("Client{id=%d, name='%s %s', email='%s', city='%s'}", 
            clientId, firstName, lastName, email, city);
    }
}