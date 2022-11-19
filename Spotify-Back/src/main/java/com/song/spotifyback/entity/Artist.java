package com.song.spotifyback.entity;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@Table(name = "Artist")
@Data
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Artist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "artist_id")
    private Long id;

    @Column(length = 20, nullable = false, name = "artist_name")
    private String name;

    @Column(length = 100, nullable = false, name = "artist_imagePath")
    private  String imagePath;

    @JsonIgnore
    @OneToMany(mappedBy = "artist")
    private List<Album> albums = new ArrayList<Album>();
}
