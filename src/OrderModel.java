import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderModel implements Model {
    private Integer orderId;
    private Integer clientId;
    private Double totalAmount;
    private Timestamp createdAt;
    private String status;

    @Override
    public void getAll() {
        String sql = "SELECT * FROM orders ORDER BY created_at DESC";
        List<OrderModel> orders = new ArrayList<>();

        try (var conn = MySQLConnection.connect();
            var stmt = conn.createStatement();
            var rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setOrderId(rs.getInt("order_id"));
                order.setClientId(rs.getInt("client_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setStatus(rs.getString("status"));
                
                orders.add(order);
                System.out.println(order);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void getId(Integer id) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    this.orderId = rs.getInt("order_id");
                    this.clientId = rs.getInt("client_id");
                    this.totalAmount = rs.getDouble("total_amount");
                    this.createdAt = rs.getTimestamp("created_at");
                    this.status = rs.getString("status");
                    
                    System.out.println(this);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void updateRowId(Integer id, String[] newValues) {
        String sql = "UPDATE orders SET client_id = ?, total_amount = ?, status = ? WHERE order_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, Integer.parseInt(newValues[0])); // client_id
            stmt.setDouble(2, Double.parseDouble(newValues[1])); // total_amount
            stmt.setString(3, newValues[2]); // status
            stmt.setInt(4, id);
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) mise(s) à jour");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void deleteRowId(Integer id) {
        String sql = "DELETE FROM orders WHERE order_id = ?";
        
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
        String sql = "INSERT INTO orders (client_id, total_amount, status) VALUES (?, ?, ?)";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, Integer.parseInt(values[0])); // client_id
            stmt.setDouble(2, Double.parseDouble(values[1])); // total_amount
            stmt.setString(3, values[2]); // status
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) insérée(s)");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    // Getters et Setters
    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public Integer getClientId() { return clientId; }
    public void setClientId(Integer clientId) { this.clientId = clientId; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return String.format("Order{id=%d, clientId=%d, amount=%.2f, status='%s', created=%s}", 
            orderId, clientId, totalAmount, status, createdAt);
    }
}