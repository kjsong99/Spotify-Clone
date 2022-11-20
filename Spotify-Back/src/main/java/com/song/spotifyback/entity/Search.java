package com.song.spotifyback.entity;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Data
@JsonSerialize(contentAs = Search.class)
public class Search {
    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private String category;

    private String image_path;
}
