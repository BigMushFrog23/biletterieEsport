import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventModel implements Model {
    private Integer eventId;
    private String name;
    private String description;
    private String venue;
    private Timestamp startDate;
    private Timestamp endDate;
    private Integer capacity;
    private Timestamp createdAt;

    // Implémentation de l'interface Model
    @Override
    public void getAll() {
        String sql = "SELECT * FROM events ORDER BY start_date";
        List<EventModel> events = new ArrayList<>();

        try (var conn = MySQLConnection.connect();
            var stmt = conn.createStatement();
            var rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                EventModel event = new EventModel();
                event.setEventId(rs.getInt("event_id"));
                event.setName(rs.getString("name"));
                event.setDescription(rs.getString("description"));
                event.setVenue(rs.getString("venue"));
                event.setStartDate(rs.getTimestamp("start_date"));
                event.setEndDate(rs.getTimestamp("end_date"));
                event.setCapacity(rs.getInt("capacity"));
                event.setCreatedAt(rs.getTimestamp("created_at"));
                
                events.add(event);
                System.out.println(event);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void getId(Integer id) {
        String sql = "SELECT * FROM events WHERE event_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (var rs = stmt.executeQuery()) {
                if (rs.next()) {
                    this.eventId = rs.getInt("event_id");
                    this.name = rs.getString("name");
                    this.description = rs.getString("description");
                    this.venue = rs.getString("venue");
                    this.startDate = rs.getTimestamp("start_date");
                    this.endDate = rs.getTimestamp("end_date");
                    this.capacity = rs.getInt("capacity");
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
        String sql = "UPDATE events SET name = ?, description = ?, venue = ?, start_date = ?, end_date = ?, capacity = ? WHERE event_id = ?";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newValues[0]); // name
            stmt.setString(2, newValues[1]); // description
            stmt.setString(3, newValues[2]); // venue
            stmt.setTimestamp(4, Timestamp.valueOf(newValues[3])); // start_date
            stmt.setTimestamp(5, Timestamp.valueOf(newValues[4])); // end_date
            stmt.setInt(6, Integer.parseInt(newValues[5])); // capacity
            stmt.setInt(7, id);
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) mise(s) à jour");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void deleteRowId(Integer id) {
        String sql = "DELETE FROM events WHERE event_id = ?";
        
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
        String sql = "INSERT INTO events (name, description, venue, start_date, end_date, capacity) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (var conn = MySQLConnection.connect();
            var stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, values[0]); // name
            stmt.setString(2, values[1]); // description
            stmt.setString(3, values[2]); // venue
            stmt.setTimestamp(4, Timestamp.valueOf(values[3])); // start_date
            stmt.setTimestamp(5, Timestamp.valueOf(values[4])); // end_date
            stmt.setInt(6, Integer.parseInt(values[5])); // capacity
            
            int affectedRows = stmt.executeUpdate();
            System.out.println(affectedRows + " ligne(s) insérée(s)");
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    // Getters et Setters
    public Integer getEventId() { return eventId; }
    public void setEventId(Integer eventId) { this.eventId = eventId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }

    public Timestamp getStartDate() { return startDate; }
    public void setStartDate(Timestamp startDate) { this.startDate = startDate; }

    public Timestamp getEndDate() { return endDate; }
    public void setEndDate(Timestamp endDate) { this.endDate = endDate; }

    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return String.format("Event{id=%d, name='%s', venue='%s', start=%s}", 
            eventId, name, venue, startDate);
    }
}