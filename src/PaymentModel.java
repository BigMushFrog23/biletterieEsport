import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentModel implements Model {
    private Integer paymentId;
    private Integer orderId;
    private Double amount;
    private String method;
    private Timestamp paidAt;
    private String status;

    @Override
    public void getAll() {
        String sql = "SELECT * FROM payments ORDER BY paid_at DESC";
        List<PaymentModel> payments = new ArrayList<>();

        try (var conn = MySQLConnection.connect();
            var stmt = conn.createStatement();
            var rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                PaymentModel payment = new PaymentModel();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setMethod(rs.getString("method"));
                payment.setPaidAt(rs.getTimestamp("paid_at"));
                payment.setStatus(rs.getString("status"));
                
                payments.add(payment);
                System.out.println(payment);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void getId(Integer id) {
        String sql = "SELECT * FROM payments WHERE payment_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    this.paymentId = rs.getInt("payment_id");
                    this.orderId = rs.getInt("order_id");
                    this.amount = rs.getDouble("amount");
                    this.method = rs.getString("method");
                    this.paidAt = rs.getTimestamp("paid_at");
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
        String sql = "UPDATE payments SET order_id = ?, amount = ?, method = ?, status = ? WHERE payment_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, Integer.parseInt(newValues[0])); // order_id
            stmt.setDouble(2, Double.parseDouble(newValues[1])); // amount
            stmt.setString(3, newValues[2]); // method
            stmt.setString(4, newValues[3]); // status
            stmt.setInt(5, id);
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) mise(s) à jour");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void deleteRowId(Integer id) {
        String sql = "DELETE FROM payments WHERE payment_id = ?";
        
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
        String sql = "INSERT INTO payments (order_id, amount, method, status) VALUES (?, ?, ?, ?)";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, Integer.parseInt(values[0])); // order_id
            stmt.setDouble(2, Double.parseDouble(values[1])); // amount
            stmt.setString(3, values[2]); // method
            stmt.setString(4, values[3]); // status
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) insérée(s)");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    // Getters et Setters
    public Integer getPaymentId() { return paymentId; }
    public void setPaymentId(Integer paymentId) { this.paymentId = paymentId; }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public Timestamp getPaidAt() { return paidAt; }
    public void setPaidAt(Timestamp paidAt) { this.paidAt = paidAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return String.format("Payment{id=%d, orderId=%d, amount=%.2f, method='%s', status='%s'}", 
            paymentId, orderId, amount, method, status);
    }
}