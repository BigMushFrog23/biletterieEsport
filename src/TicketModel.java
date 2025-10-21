import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketModel implements Model {
    private Integer ticketId;
    private Integer eventId;
    private Integer clientId;
    private Integer orderId;
    private String category;
    private Double price;
    private String seat;
    private Timestamp purchaseDate;
    private String status;
    private String qrCode;

    @Override
    public void getAll() {
        String sql = "SELECT * FROM tickets ORDER BY purchase_date DESC";
        List<TicketModel> tickets = new ArrayList<>();

        try (var conn = MySQLConnection.connect();
            var stmt = conn.createStatement();
            var rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                TicketModel ticket = new TicketModel();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setEventId(rs.getInt("event_id"));
                ticket.setClientId(rs.getInt("client_id"));
                ticket.setOrderId(rs.getInt("order_id"));
                ticket.setCategory(rs.getString("category"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setSeat(rs.getString("seat"));
                ticket.setPurchaseDate(rs.getTimestamp("purchase_date"));
                ticket.setStatus(rs.getString("status"));
                ticket.setQrCode(rs.getString("qr_code"));
                
                tickets.add(ticket);
                System.out.println(ticket);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void getId(Integer id) {
        String sql = "SELECT * FROM tickets WHERE ticket_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    this.ticketId = rs.getInt("ticket_id");
                    this.eventId = rs.getInt("event_id");
                    this.clientId = rs.getInt("client_id");
                    this.orderId = rs.getInt("order_id");
                    this.category = rs.getString("category");
                    this.price = rs.getDouble("price");
                    this.seat = rs.getString("seat");
                    this.purchaseDate = rs.getTimestamp("purchase_date");
                    this.status = rs.getString("status");
                    this.qrCode = rs.getString("qr_code");
                    
                    System.out.println(this);
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void updateRowId(Integer id, String[] newValues) {
        String sql = "UPDATE tickets SET event_id = ?, client_id = ?, order_id = ?, category = ?, price = ?, seat = ?, status = ? WHERE ticket_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, Integer.parseInt(newValues[0])); // event_id
            stmt.setInt(2, Integer.parseInt(newValues[1])); // client_id
            stmt.setInt(3, Integer.parseInt(newValues[2])); // order_id
            stmt.setString(4, newValues[3]); // category
            stmt.setDouble(5, Double.parseDouble(newValues[4])); // price
            stmt.setString(6, newValues[5]); // seat
            stmt.setString(7, newValues[6]); // status
            stmt.setInt(8, id);
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) mise(s) à jour");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void deleteRowId(Integer id) {
        String sql = "DELETE FROM tickets WHERE ticket_id = ?";
        
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
        String sql = "INSERT INTO tickets (event_id, client_id, order_id, category, price, seat, status, qr_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, Integer.parseInt(values[0])); // event_id
            stmt.setInt(2, Integer.parseInt(values[1])); // client_id
            stmt.setInt(3, Integer.parseInt(values[2])); // order_id
            stmt.setString(4, values[3]); // category
            stmt.setDouble(5, Double.parseDouble(values[4])); // price
            stmt.setString(6, values[5]); // seat
            stmt.setString(7, values[6]); // status
            stmt.setString(8, values[7]); // qr_code
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) insérée(s)");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    // Getters et Setters
    public Integer getTicketId() { return ticketId; }
    public void setTicketId(Integer ticketId) { this.ticketId = ticketId; }

    public Integer getEventId() { return eventId; }
    public void setEventId(Integer eventId) { this.eventId = eventId; }

    public Integer getClientId() { return clientId; }
    public void setClientId(Integer clientId) { this.clientId = clientId; }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getSeat() { return seat; }
    public void setSeat(String seat) { this.seat = seat; }

    public Timestamp getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(Timestamp purchaseDate) { this.purchaseDate = purchaseDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getQrCode() { return qrCode; }
    public void setQrCode(String qrCode) { this.qrCode = qrCode; }

    @Override
    public String toString() {
        return String.format("Ticket{id=%d, eventId=%d, clientId=%d, category='%s', seat='%s', status='%s'}", 
            ticketId, eventId, clientId, category, seat, status);
    }
}