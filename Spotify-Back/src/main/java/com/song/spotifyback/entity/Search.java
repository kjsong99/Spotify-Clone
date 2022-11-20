package com.song.spotifyback.entity;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;

import javax.persistence.*;

@Entity
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Data
@JsonSerialize(contentAs = Search.class)
public class Search {
    private Long value_id;

    private String name;

    private String category;

    private String image_path;
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)

    @Column(name ="id")
    private Long id;

    public void setId(Long id) {
        this.id = id;
    }

    @Id
    public Long getId() {
        return id;
    }
}
