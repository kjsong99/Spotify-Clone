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
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@ToString
@Table(name = "Music")
@EntityListeners(AuditingEntityListener.class)
public class Music {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "music_id")
    private Long id;

    @Column(length = 100, nullable = false, name = "music_name")
    private String name;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "album_id")
    private Album album;

    @Column(name = "music_imagePath", length = 100, nullable = false)
    private String imagePath;

    @JsonSerialize(contentAs = MusicArtist.class)
    @OneToMany(mappedBy = "music")
    private List<MusicArtist> artists = new ArrayList<MusicArtist>();

    @JsonSerialize(contentAs = MusicFeatures.class)
    @OneToMany(mappedBy = "music")
    private List<MusicFeatures> features = new ArrayList<MusicFeatures>();



}
