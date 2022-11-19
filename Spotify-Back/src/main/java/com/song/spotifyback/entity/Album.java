package com.song.spotifyback.entity;


import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Data
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EntityListeners(AuditingEntityListener.class)
@Table(name = "Album")
public class Album {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "album_id")
    private Long id;

    @Column(length = 50, nullable = false, name = "album_name")
    private String name;

    @Column(updatable = false, nullable = false, name = "album_date")
    @CreatedDate
    private LocalDate date;

    @Column(length = 100, nullable = false, name = "album_imagePath")
    private String imagePath;


    @JsonSerialize(contentAs = Artist.class)
    @ManyToOne
    @JoinColumn(name = "artist_id")
    private Artist artist;

    @JsonSerialize(contentAs = Music.class)
    @OneToMany(mappedBy = "album")
    private List<Music> musics = new ArrayList<Music>();
}
